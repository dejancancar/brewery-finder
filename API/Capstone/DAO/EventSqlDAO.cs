using Capstone.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.DAO
{
    public class EventSqlDAO : IEventDAO
    {
        public readonly string connectionString;
        public const string SQL_GET_EVENTS = @"SELECT TOP 15 be.*, b.brewery_name
	                                            FROM brewery_events be
	                                            JOIN breweries b ON b.brewery_id = be.brewery_id
	                                            WHERE date_and_time >= CURRENT_TIMESTAMP
	                                            ORDER BY date_and_time ASC";
        public const string SQL_GET_EVENTS_BY_BREWERY = @"SELECT TOP 15 be.*, b.brewery_name
                                                FROM brewery_events be
                                                JOIN breweries b ON b.brewery_id = be.brewery_id
                                                WHERE date_and_time >= CURRENT_TIMESTAMP AND b.brewery_id = @breweryId
                                                ORDER BY date_and_time ASC";
        public EventSqlDAO(string dbConnectionString)
        {
            this.connectionString = dbConnectionString;
        }

        public List<BreweryEvent> GetEvents()
        {
            List<BreweryEvent> events = new List<BreweryEvent>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_GET_EVENTS, conn);

                    SqlDataReader reader = cmd.ExecuteReader();
                    
                    while (reader.Read())
                    {
                        BreweryEvent be = RowToObject(reader);
                        events.Add(be);
                    }

                }

                return events;
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        public List<BreweryEvent> GetEventsByBrewery(int breweryId)
        {
            List<BreweryEvent> events = new List<BreweryEvent>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_GET_EVENTS_BY_BREWERY, conn);

                    cmd.Parameters.AddWithValue("@breweryId", breweryId);

                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        BreweryEvent be = RowToObject(reader);
                        events.Add(be);
                    }

                    return events;

                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }


        private static BreweryEvent RowToObject(SqlDataReader r)
        {
            BreweryEvent be = new BreweryEvent();

            be.BreweryEventId = Convert.ToInt32(r["brewery_event_id"]);
            be.BreweryId = Convert.ToInt32(r["brewery_id"]);
            be.Title = Convert.ToString(r["title"]);
            be.Description = Convert.ToString(r["description"]);
            be.DateAndTime = Convert.ToDateTime(r["date_and_time"]);
            be.BreweryName = Convert.ToString(r["brewery_name"]);

            return be;

        }

    }
}
