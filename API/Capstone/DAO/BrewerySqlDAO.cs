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
                                                    INSERT INTO breweries(brewery_name, user_id, history, is_active) 
                                                    VALUES(@breweryName, @userId, @history, @isActive); 
                                                    SELECT * FROM breweries WHERE brewery_id = @@identity;
                                                    Commit Transaction";
        private const string SQL_GET_BREWERIES = "SELECT * FROM breweries;";
        private const string SQL_GET_LOCATIONS = "SELECT * FROM locations WHERE brewery_id = @breweryId;";

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
                        

                        output.Add(createdBrewery);
                    }

                    reader.Close();

                    for (int i = 0; i < output.Count; i++)
                    {
                        cmd = new SqlCommand(SQL_GET_LOCATIONS, conn);

                        cmd.Parameters.AddWithValue("@breweryId", output[i].BreweryId);
                        reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            Location location = new Location();

                            location.LocationId = Convert.ToInt32(reader["location_id"]);
                            location.BreweryId = Convert.ToInt32(reader["brewery_id"]);
                            location.StreetAddress = Convert.ToString(reader["street_address"]);
                            location.Phone = Convert.ToString(reader["phone"]);
                            location.City = Convert.ToString(reader["city"]);
                            location.ZipCode = Convert.ToString(reader["zip_code"]);

                            output[i].Locations.Add(location);
                        }

                        reader.Close();
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
                    cmd.Parameters.AddWithValue("@isActive", true);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        createdBrewery = new Brewery();
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
