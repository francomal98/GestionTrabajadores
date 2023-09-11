using System.Text;

namespace GestionTrabajadores.Services
{
    public class GeneratorIdService
    {
        public string GenerateIdentifier()
        {
            Random random = new Random();
            string characters = "+-_#!&*@?0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
            int lengthString = 8;
            StringBuilder result = new StringBuilder(lengthString);

            for(int i = 0; i < characters.Length; i++)
            {
                int index = random.Next(0, characters.Length);
                result.Append(characters[index]);
            }

            return result.ToString();
        }
    }
}
