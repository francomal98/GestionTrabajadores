using System.Net;
using System.Net.Mail;
using System.Text;

namespace GestionTrabajadores.Services
{
    public class EmailService
    {
        public bool SendRecoveryPassMail(string mail, string identificador)
        {
            try
            {
                var configuration = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json")
                    .Build();

                MailMessage message = new MailMessage();
                message.From = new MailAddress(configuration["SmtpConfig:email"], "Desarrollos Franco");
                message.Subject = "Recuperación de Contraseña";
                message.Body = "<h5>Pruebas de Envio</h5>";
                message.IsBodyHtml = true;
                message.BodyEncoding = Encoding.UTF8;
                message.SubjectEncoding = Encoding.UTF8;
                message.To.Add(mail);

                SmtpClient smtp = new SmtpClient(configuration["SmtpConfig:servidor"], int.Parse(configuration["SmtpConfig:puerto"]));
                smtp.EnableSsl = true;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new NetworkCredential(configuration["SmtpConfig:email"], configuration["SmtpConfig:contrasena"]);

                try
                {
                    smtp.Send(message);
                    message.Dispose();
                    smtp.Dispose();

                    return true;
                } catch(Exception ex)
                {
                    return false;
                }
                
            } catch(Exception ex)
            {
                return false;
            }
        }

        public bool SendRecoveryActiveAccount(string mail, string nombre, string url)
        {
            try
            {
                var configuration = new ConfigurationBuilder()
                    .SetBasePath(Directory.GetCurrentDirectory())
                    .AddJsonFile("appsettings.json")
                    .Build();

                string path = Directory.GetCurrentDirectory() + "/Templates/EmailActivaciónCuenta.html";

                StreamReader reader = new StreamReader(path);
                string txttemplate = reader.ReadToEnd();
                reader.Close();

                txttemplate = txttemplate.Replace("--nombre", nombre);
                txttemplate = txttemplate.Replace("--portalweb", "https://localhost:4200");
                txttemplate = txttemplate.Replace("--url", url);

                MailMessage message = new MailMessage();
                message.From = new MailAddress(configuration["SmtpConfig:email"], "Desarrollos Franco");
                message.Subject = "Recuperación de Contraseña";
                message.Body = txttemplate;
                message.IsBodyHtml = true;
                message.BodyEncoding = Encoding.UTF8;
                message.SubjectEncoding = Encoding.UTF8;
                message.To.Add(mail);

                SmtpClient smtp = new SmtpClient(configuration["SmtpConfig:servidor"], int.Parse(configuration["SmtpConfig:puerto"]));
                smtp.EnableSsl = true;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = new NetworkCredential(configuration["SmtpConfig:email"], configuration["SmtpConfig:contrasena"]);

                try
                {
                    smtp.Send(message);
                    message.Dispose();
                    smtp.Dispose();

                    return true;
                }
                catch (Exception ex)
                {
                    return false;
                }

            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
