﻿using System.Collections.Generic;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface IUserDAO
    {
        User GetUser(string username);
        User AddUser(string username, string password, string role);
        List<ReturnUser> GetUsers();
        List<ReturnUser> GetUsers(string username);
    }
}
