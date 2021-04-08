using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public class BreweryImagesSqlDAO : IBreweryImagesDAO
    {
        private readonly string connectionString;
        private const string SQL_CREATE_IMAGE = "INSERT INTO brewery_images (brewery_id, image_url) VALUES (@breweryId, @imageUrl); SELECT @@IDENTITY;";

        public BreweryImagesSqlDAO(string dbConnectionString)
        {
            this.connectionString = dbConnectionString;
        }

        public BreweryImage CreateImage(int breweryId, string url)
        {
            BreweryImage bi = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_CREATE_IMAGE, conn);
                    cmd.Parameters.AddWithValue("@breweryId", breweryId);
                    cmd.Parameters.AddWithValue("@imageUrl", url);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        bi = RowToObject(reader);
                    }
                }

                return bi;
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        private static BreweryImage RowToObject(SqlDataReader reader)
        {
            BreweryImage bi = new BreweryImage();

            bi.BreweryImageId = Convert.ToInt32(reader["brewery_image_id"]);
            bi.BreweryId = Convert.ToInt32(reader["brewery_id"]);
            bi.ImageUrl = Convert.ToString(reader["image_url"]);

            return bi;
        }


    }
}
