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

        [HttpPost("{userId}/favorites")]
        public ActionResult CreateFavorite(int userId, BreweryFavorite favorite)
        {
            bool addedToFavorites = userDAO.CreateFavorite(favorite);

            if (addedToFavorites)
            {
                return NoContent();
            }
            else
            {
                return BadRequest();
            }
        }

        [HttpDelete("{userId}/favorites")]
        public ActionResult DeleteFavorite(int userId, int breweryId)
        {
            bool deletedFromFavorites = userDAO.DeleteFavorite(userId, breweryId);

            if (deletedFromFavorites == true)
            {
                return NoContent();
            }
            else
            {
                return BadRequest();
            }
        }
    }


}
