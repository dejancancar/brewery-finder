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
        private const string SQL_CREATE_BEER = @"INSERT INTO beers (brewery_id, image_url, abv, beer_type, is_active) VALUES (@breweryId, @imageUrl, @abv, @beerType, @isActive)
                                                    SELECT * FROM beers WHERE beer_id = @@IDENTITY;";
        public BeerSqlDAO(string dbConnectionString)
        {
            this.connectionString = dbConnectionString;
        }

        public Beer CreateBeer(Beer beer)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_CREATE_BEER, conn);

                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

    }
}
