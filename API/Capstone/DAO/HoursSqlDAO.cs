using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public class HoursSqlDAO : IHoursDAO
    {
        private readonly string connectionString;
        private const string SQL_GET_HOURS = "SELECT * FROM hours WHERE brewery_id = @breweryId;";
        private const string SQL_UPDATE_HOURS = @"UPDATE hours SET brewery_id = @breweryId, day_of_week = @dayOfWeek, open_hour = @openHour, open_minute = @openMinute, 
                                                    open_am_pm = @openAmPm, close_hour = @closeHour, close_minute = @closeMinute, close_am_pm = @closeAmPm, is_closed = @isCLosed
                                                    WHERE hours_id = @hoursId;
                                                    SELECT * FROM hours WHERE hours_id = @hoursId;";

        public HoursSqlDAO(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public List<Hours> GetHours(int breweryId)
        {
            List<Hours> hoursList = new List<Hours>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_GET_HOURS, conn);
                    cmd.Parameters.AddWithValue("@breweryId", breweryId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        Hours hours = RowToObject(reader);
                        hoursList.Add(hours);
                    }

                    return hoursList;
                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        public Hours UpdateHours(Hours hours)
        {
            Hours updatedHours = null;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_UPDATE_HOURS, conn);
                    cmd.Parameters.AddWithValue("@hoursId", hours.HoursId);
                    cmd.Parameters.AddWithValue("@breweryId", hours.BreweryId);
                    cmd.Parameters.AddWithValue("@dayOfWeek", hours.DayOfWeek);
                    cmd.Parameters.AddWithValue("@openHour", hours.OpenHour);
                    cmd.Parameters.AddWithValue("@openMinute", hours.OpenMinute);
                    cmd.Parameters.AddWithValue("@openAmPm", hours.OpenAmPm);
                    cmd.Parameters.AddWithValue("@closeHour", hours.CloseHour);
                    cmd.Parameters.AddWithValue("@closeMinute", hours.CloseMinute);
                    cmd.Parameters.AddWithValue("@closeAmPm", hours.CloseAmPm);
                    cmd.Parameters.AddWithValue("@isClosed", hours.IsClosed);

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        updatedHours = RowToObject(reader);
                    }

                    return updatedHours;

                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        private static Hours RowToObject(SqlDataReader reader)
        {
            Hours hours = new Hours();

            hours.HoursId = Convert.ToInt32(reader["hours_id"]);
            hours.BreweryId = Convert.ToInt32(reader["brewery_id"]);
            hours.DayOfWeek = Convert.ToInt32(reader["day_of_week"]);
            hours.OpenHour = Convert.ToInt32(reader["open_hour"]);
            hours.OpenMinute = Convert.ToInt32(reader["open_minute"]);
            hours.OpenAmPm = Convert.ToString(reader["open_am_pm"]);
            hours.CloseHour = Convert.ToInt32(reader["close_hour"]);
            hours.CloseMinute = Convert.ToInt32(reader["close_minute"]);
            hours.CloseAmPm = Convert.ToString(reader["close_am_pm"]);
            hours.IsClosed = Convert.ToBoolean(reader["is_closed"]);

            return hours;
        }
    }
}
