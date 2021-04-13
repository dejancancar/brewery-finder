using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Capstone.Models;
using Capstone.Security;
using Capstone.Security.Models;

namespace Capstone.DAO
{
    public class UserSqlDAO : IUserDAO
    {
        private readonly string connectionString;
        private const string SQL_GET_USERS = "SELECT user_id, username, user_role FROM users;";
        private const string SQL_GET_USERS_FILTERED = "SELECT user_id, username, user_role FROM users WHERE username LIKE @username;";
        private const string SQL_CREATE_FAVORITE = "INSERT INTO breweries_users (brewery_id, user_id) VALUES (@breweryId, @userId);";
        private const string SQL_DELETE_FAVORITE = "DELETE FROM breweries_users WHERE user_id = @userId AND brewery_id = @breweryId";
        public UserSqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<ReturnUser> GetUsers()
        {
            List<ReturnUser> users = new List<ReturnUser>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_GET_USERS, conn);

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        ReturnUser user = GetReturnUserFromReader(rdr);
                        users.Add(user);
                    }
                }

                return users;
            }
            catch (SqlException ex)
            {

                throw;
            }
        }
        public List<ReturnUser> GetUsers(string username)
        {
            username = $"%{username}%";

            List<ReturnUser> users = new List<ReturnUser>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_GET_USERS_FILTERED, conn);
                    cmd.Parameters.AddWithValue("@username", username);

                    SqlDataReader rdr = cmd.ExecuteReader();

                    while (rdr.Read())
                    {
                        ReturnUser user = GetReturnUserFromReader(rdr);
                        users.Add(user);
                    }
                }

                return users;
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        public User GetUser(string username)
        {
            User returnUser = null;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("SELECT user_id, username, password_hash, salt, user_role FROM users WHERE username = @username", conn);
                    cmd.Parameters.AddWithValue("@username", username);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows && reader.Read())
                    {
                        returnUser = GetUserFromReader(reader);
                    }
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return returnUser;
        }


        public User AddUser(string username, string password, string role)
        {
            IPasswordHasher passwordHasher = new PasswordHasher();
            PasswordHash hash = passwordHasher.ComputeHash(password);

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand("INSERT INTO users (username, password_hash, salt, user_role) VALUES (@username, @password_hash, @salt, @user_role)", conn);
                    cmd.Parameters.AddWithValue("@username", username);
                    cmd.Parameters.AddWithValue("@password_hash", hash.Password);
                    cmd.Parameters.AddWithValue("@salt", hash.Salt);
                    cmd.Parameters.AddWithValue("@user_role", role);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (SqlException)
            {
                throw;
            }

            return GetUser(username);
        }

        public bool CreateFavorite(BreweryFavorite favorite)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_CREATE_FAVORITE, conn);
                    cmd.Parameters.AddWithValue("@userId", favorite.UserId);
                    cmd.Parameters.AddWithValue("@breweryId", favorite.BreweryId);

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected == 1)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        public bool DeleteFavorite(int userId, int breweryId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_DELETE_FAVORITE, conn);
                    cmd.Parameters.AddWithValue("@userId", userId);
                    cmd.Parameters.AddWithValue("@breweryId", breweryId);

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected == 1)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }


        private User GetUserFromReader(SqlDataReader reader)
        {
            User u = new User()
            {
                UserId = Convert.ToInt32(reader["user_id"]),
                Username = Convert.ToString(reader["username"]),
                PasswordHash = Convert.ToString(reader["password_hash"]),
                Salt = Convert.ToString(reader["salt"]),
                Role = Convert.ToString(reader["user_role"]),
            };

            return u;
        }

        private ReturnUser GetReturnUserFromReader(SqlDataReader reader)
        {
            ReturnUser user = new ReturnUser();

            user.UserId = Convert.ToInt32(reader["user_id"]);
            user.Username = Convert.ToString(reader["username"]);
            user.Role = Convert.ToString(reader["user_role"]);

            return user;
        }
    }
}
