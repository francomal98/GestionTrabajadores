using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace GestionTrabajadores.Services
{
    public class JwtService
    {
        public object GenerateJwt(string key, int idUser, string username, string issuer, string audience) {
            try
            {
                JwtSecurityTokenHandler handlerToken = new JwtSecurityTokenHandler();
                var _key = Encoding.UTF8.GetBytes(key);
                var tokenDes = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new Claim[]
                    {
                        new Claim(ClaimTypes.Name, username),
                        new Claim("UserId", idUser.ToString())
                    }),
                    Expires = DateTime.Now.AddDays(1),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(_key),
                                                    SecurityAlgorithms.HmacSha256Signature),
                    Issuer = issuer,
                    Audience = audience
                };

                var token = handlerToken.CreateToken(tokenDes);

                object result = new
                {
                    response = "Credenciales Validas",
                    token = handlerToken.WriteToken(token),
                    expires = DateTime.Now.AddDays(1)
                };

                return result;
            }
            catch (Exception ex)
            {
                object result = new { error = ex.Message };
                return result;
            }
        }

        public string GenerateJwtRecoverPass(string key, int idUser)
        {
            try
            {
                JwtSecurityTokenHandler handlerToken = new JwtSecurityTokenHandler();
                var _key = Encoding.UTF8.GetBytes(key);
                var tokenDes = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new Claim[]
                    {
                            new Claim("UserId", idUser.ToString())
                    }),
                    Expires = DateTime.UtcNow.AddMinutes(30),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(_key),
                                                    SecurityAlgorithms.HmacSha256Signature)
                };

                var token = handlerToken.CreateToken(tokenDes);

                return handlerToken.WriteToken(token);
            } catch(Exception ex)
            {
                return "";
            }
        }

        public string GenerateJwtActiveAccount(string key, string username)
        {
            try
            {
                JwtSecurityTokenHandler handlerToken = new JwtSecurityTokenHandler();
                var _key = Encoding.UTF8.GetBytes(key);
                var tokenDes = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new Claim[]
                    {
                        new Claim("UserName", username)
                    }),
                    Expires = DateTime.UtcNow.AddMinutes(60),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(_key),
                                                    SecurityAlgorithms.HmacSha256Signature)
                };

                var token = handlerToken.CreateToken(tokenDes);

                return handlerToken.WriteToken(token);
            }
            catch (Exception ex)
            {
                return "";
            }
        }

        public string ValidateToken(string token, string key, int tokentype)
        {
            try
            {
                string valueToken = String.Empty;
                JwtSecurityTokenHandler tokenHandlres = new JwtSecurityTokenHandler();
                TokenValidationParameters tokenValidation = new TokenValidationParameters()
                {
                    ValidateIssuerSigningKey = true,
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(key)),
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero
                };

                SecurityToken security;
                var principal = tokenHandlres.ValidateToken(token, tokenValidation, out security);

                if(security.ValidTo < DateTime.UtcNow)
                {
                    return null;
                }


                if(tokentype == 1) {
                    return principal.FindFirst("UserId").Value;
                } else
                {
                    return principal.FindFirst("UserName").Value;
                }
            } catch(Exception ex)
            {
                return null;
            }
        }
    }
}
