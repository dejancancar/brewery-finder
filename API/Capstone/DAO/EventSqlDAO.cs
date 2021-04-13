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
        private readonly string connectionString;
        private const string SQL_GET_EVENTS = @"SELECT TOP 15 be.*, b.brewery_name
	                                            FROM brewery_events be
	                                            JOIN breweries b ON b.brewery_id = be.brewery_id
	                                            WHERE date_and_time >= CURRENT_TIMESTAMP
	                                            ORDER BY date_and_time ASC";
        private const string SQL_GET_EVENTS_BY_BREWERY = @"SELECT TOP 15 be.*, b.brewery_name
                                                FROM brewery_events be
                                                JOIN breweries b ON b.brewery_id = be.brewery_id
                                                WHERE date_and_time >= CURRENT_TIMESTAMP AND b.brewery_id = @breweryId
                                                ORDER BY date_and_time ASC";
        private const string SQL_CREATE_EVENT = @"INSERT INTO brewery_events (brewery_id, title, description, date_and_time)
                                                    VALUES (@breweryId, @title, @description, @dateAndTime);
                                                    SELECT be.*, b.brewery_name
	                                                    FROM brewery_events be
	                                                    JOIN breweries b ON b.brewery_id = be.brewery_id
	                                                    WHERE brewery_event_id = @@IDENTITY;";
        private const string SQL_DELETE_EVENT = "DELETE FROM brewery_events WHERE brewery_event_id = @eventId;";

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

        public BreweryEvent CreateEvent(BreweryEvent breweryEvent)
        {
            BreweryEvent createdEvent = null;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_CREATE_EVENT, conn);
                    cmd.Parameters.AddWithValue("@breweryId", breweryEvent.BreweryId);
                    cmd.Parameters.AddWithValue("@title", breweryEvent.Title);
                    cmd.Parameters.AddWithValue("@description", breweryEvent.Description);
                    cmd.Parameters.AddWithValue("@dateAndTime", breweryEvent.DateAndTime);

                    SqlDataReader reader = cmd.ExecuteReader();
                    
                    if (reader.Read())
                    {
                        createdEvent = RowToObject(reader);
                    }

                    return createdEvent;
                }
            }
            catch (SqlException ex)
            {

                throw;
            }
        }

        public bool DeleteEvent(int eventId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_DELETE_EVENT, conn);

                    cmd.Parameters.AddWithValue("@eventId", eventId);

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
