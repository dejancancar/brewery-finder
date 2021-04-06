using Capstone.DAO;
using Capstone.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Controllers
{
    [Route("Users")]
    [ApiController]
    public class UsersController : AuthorizedControllerBase
    {
        IUserDAO userDAO;
        public UsersController(IUserDAO userDAO)
        {
            this.userDAO = userDAO;
        }

        [HttpGet]
        public ActionResult<List<ReturnUser>> GetUsers(string username = "")
        {
            List<ReturnUser> users = null;

            if (username == "")
            {
                users = userDAO.GetUsers();
            }
            else
            {
                users = userDAO.GetUsers(username);
            }

            if (users != null)
            {
                return Ok(users);
            }
            else
            {
                return BadRequest();
            }
        }
    }


}
