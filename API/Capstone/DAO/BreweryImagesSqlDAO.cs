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
        private const string SQL_CREATE_IMAGE = "INSERT INTO brewery_images (brewery_id, file_name) VALUES (@breweryId, @fileName);";
        public BreweryImagesSqlDAO(string dbConnectionString)
        {
            this.connectionString = dbConnectionString;
        }
        public bool CreateImage(int breweryId, string newFileName)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_CREATE_IMAGE, conn);
                    cmd.Parameters.AddWithValue("@fileName", newFileName);
                    cmd.Parameters.AddWithValue("@breweryId", breweryId);

                    int affectedRows = cmd.ExecuteNonQuery();

                    if (affectedRows == 1)
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

    }
}
