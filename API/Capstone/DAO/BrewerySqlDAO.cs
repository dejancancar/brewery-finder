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
                                                    UPDATE users SET user_role = 'brewer' WHERE user_id = @userId;
                                                    INSERT INTO breweries(brewery_name, user_id, history, phone, street_address, city, zip_code, is_active) 
                                                    VALUES(@breweryName, @userId, @history, @phone, @streetAddress, @city, @zipCode, @isActive); 
                                                    SELECT * FROM breweries WHERE brewery_id = @@identity;
                                                    Commit Transaction";
        private const string SQL_GET_BREWERIES = "SELECT * FROM breweries;";
        //private const string SQL_GET_LOCATIONS = "SELECT * FROM locations WHERE brewery_id = @breweryId;";

        public BrewerySqlDAO(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public List<Brewery> GetBreweries()
        {
            List<Brewery> output = new List<Brewery>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_GET_BREWERIES, conn);
                    SqlDataReader reader = cmd.ExecuteReader();

                    while(reader.Read())
                    {
                        Brewery createdBrewery = new Brewery();
                        createdBrewery = new Brewery();
                        createdBrewery.Name = Convert.ToString(reader["brewery_name"]);
                        createdBrewery.UserId = Convert.ToInt32(reader["user_id"]);
                        createdBrewery.BreweryId = Convert.ToInt32(reader["brewery_id"]);
                        createdBrewery.History = Convert.ToString(reader["history"]);
                        createdBrewery.IsActive = Convert.ToBoolean(reader["is_active"]);
                        createdBrewery.StreetAddress = Convert.ToString(reader["street_address"]);
                        createdBrewery.Phone = Convert.ToString(reader["phone"]);
                        createdBrewery.City = Convert.ToString(reader["city"]);
                        createdBrewery.ZipCode = Convert.ToString(reader["zip_code"]);


                        output.Add(createdBrewery);
                    }

                    return output;
                }
            }
            catch (SqlException ex)
            {

                throw;
            }
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
                    cmd.Parameters.AddWithValue("@streetAddress", "");
                    cmd.Parameters.AddWithValue("@phone", "");
                    cmd.Parameters.AddWithValue("@city", "");
                    cmd.Parameters.AddWithValue("@zipCode", "");
                    cmd.Parameters.AddWithValue("@isActive", true);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        createdBrewery = new Brewery();
                        createdBrewery.Name = Convert.ToString(reader["brewery_name"]);
                        createdBrewery.UserId = Convert.ToInt32(reader["user_id"]);
                        createdBrewery.BreweryId = Convert.ToInt32(reader["brewery_id"]);
                        createdBrewery.History = Convert.ToString(reader["history"]);
                        createdBrewery.History = Convert.ToString(reader["street_address"]);
                        createdBrewery.History = Convert.ToString(reader["phone"]);
                        createdBrewery.History = Convert.ToString(reader["city"]);
                        createdBrewery.History = Convert.ToString(reader["zip_code"]);
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
