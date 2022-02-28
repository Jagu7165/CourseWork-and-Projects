using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace mathGame
{
   public  class clsUser
    {
        public string Name;
        public int age;
        public clsUser()
        {

        }

        public clsUser(string n, int a)
        {
            this.Name = n;
            this.age = a;
        }
        public string UserName()
        {
            return Name;
        }
        public int UserAge()
        {
            return age;
        }

    }


}
