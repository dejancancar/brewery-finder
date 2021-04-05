using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public class BrewerySqlDAO : IBreweryDAO
    {

        private readonly string connectionString;
        private const string SQL_CREATE_BREWERY = @"Begin Transaction
                                                    INSERT INTO breweries(brewery_name, user_id, history, is_active) 
                                                    VALUES(@breweryName, @userId, @history, @isActive); 
                                                    UPDATE users SET user_role = 'brewer' WHERE user_id = @userId; SELECT @@identity
                                                    Commit Transaction";

        public BrewerySqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public Brewery CreateBrewery(Brewery brewery)
        {
            Brewery createdBrewery = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(SQL_CREATE_BREWERY, conn);
                    cmd.Parameters.AddWithValue("@breweryName", brewery.Name);
                    cmd.Parameters.AddWithValue("@userId", brewery.UserId);
                    cmd.Parameters.AddWithValue("@history", "");
                    cmd.Parameters.AddWithValue("@isActive", true);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        createdBrewery.Name = Convert.ToString(reader["brewery_name"]);
                        createdBrewery.UserId = Convert.ToInt32(reader["user_id"]);
                        createdBrewery.BreweryId = Convert.ToInt32(reader["brewery_id"]);
                        createdBrewery.History = Convert.ToString(reader["history"]);
                        createdBrewery.IsActive = Convert.ToBoolean(reader["is_active"]);
                    }
                }
                return createdBrewery;
            }
            catch (SqlException ex)
            {
                throw;
            }
        }
    }
}
