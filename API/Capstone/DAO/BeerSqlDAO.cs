using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public class BeerSqlDAO : IBeerDAO
    {
        private readonly string connectionString;
        private const string SQL_GET_BEERS = "SELECT * FROM beers WHERE brewery_id = @breweryId;";
        private const string SQL_CREATE_BEER = @"INSERT INTO beers (brewery_id, beer_name, description, image_url, abv, beer_type, is_active) 
                                                    VALUES (@breweryId, @beerName, @description, @imageUrl, @abv, @beerType, @isActive)
                                                    SELECT * FROM beers WHERE beer_id = @@IDENTITY;";
        public BeerSqlDAO(string dbConnectionString)
        {
            this.connectionString = dbConnectionString;
        }

        public List<Beer> GetBeers(int breweryId)
        {
            List<Beer> beers = new List<Beer>();

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_GET_BEERS, conn);
                    cmd.Parameters.AddWithValue("@breweryId", breweryId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Beer beer = RowToObject(reader);
                        beers.Add(beer);
                    }

                    return beers;
                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        public Beer CreateBeer(Beer beer)
        {
            Beer createdBeer = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_CREATE_BEER, conn);
                    cmd.Parameters.AddWithValue("@beerName", beer.BeerName);
                    cmd.Parameters.AddWithValue("@description", beer.Description);
                    cmd.Parameters.AddWithValue("@breweryId", beer.BreweryId);
                    cmd.Parameters.AddWithValue("@imageUrl", beer.ImageUrl);
                    cmd.Parameters.AddWithValue("@abv", beer.Abv);
                    cmd.Parameters.AddWithValue("@beerType", beer.BeerType);
                    cmd.Parameters.AddWithValue("@isActive", beer.IsActive);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        createdBeer = RowToObject(reader);
                    }

                    return createdBeer;
                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        //public Beer UpdateBeer(Beer beer)
        //{

        //}
        private static Beer RowToObject(SqlDataReader reader)
        {
            Beer beer = new Beer();

            beer.BeerName = Convert.ToString(reader["beer_name"]);
            beer.Description = Convert.ToString(reader["description"]);
            beer.BreweryId = Convert.ToInt32(reader["brewery_id"]);
            beer.BeerId = Convert.ToInt32(reader["beer_id"]);
            beer.ImageUrl = Convert.ToString(reader["image_url"]);
            beer.Abv = Convert.ToString(reader["abv"]);
            beer.BeerType = Convert.ToString(reader["beer_type"]);
            beer.IsActive = Convert.ToBoolean(reader["is_active"]);

            return beer;
        }
    }
}
