# README

## Instructions to using the application with existing Interface.

  To interact with this app:
  1. clone `https://github.com/roger88ist/appt_interface` into a directory.
  2. run `ruby test.rb`
  3. Perform whatever operations you would like on the appointment application through test.rb

## Instructions to using the application outside of the existing Interface.
  URL = **https://rogeriosappointment.herokuapp.com/api/appointments**
  
  1. See individual appointment by appointment id.
  * GET request to URL followed by `/` and the id number.
  - **example:** `https://rogeriosappointment.herokuapp.com/api/appointments/1`

  2. See list of appointments by time.
  * GET request to URL followed by `/q?`, start time and end time parameters
  - **example:** `https://rogeriosappointment.herokuapp.com/api/appointments/q?start_time=2016-01-01&end_time=2016-01-02`
  - This will allow you to see all appointments for Jan 1, 2016.

  3. You can make a more specific search by including hour and minutes as well.
  * GET request to URL below and substitute `HH` and `MM` characters with desired search criteria.
  - **example:** `https://rogeriosappointment.herokuapp.com/api/appointments/q?start_time=2016-01-01%20HH:MM&end_time=2017-01-01%20HH:MM`
  - `HH` represents the hour and `MM` respresents the minutes.
  - **example:** 01:05 = 1:05AM and 15:30 = 3:30PM

  4. Search Appointments by first or last name.
  * GET request to URL followed by `/q?first_name=john` or `/q?last_name=doe`
  - It is case insensitive.

  5. Create an Appointment
  * POST request to URL 
  - include parameters: {"appointment":{"first_name":"FirstName", "last_name":"LastName", "start_time":"AppointmentStartTime", "end_time":"AppointmentEndTime", "comments":"LeaveCommentsHere"}}
  - All keys are necessary except for comments. If any other key does not have a value an appointment will not be created.

  6. Update an Appointment
  * PUT request to URL followed by `/` and the id number for the specific appointment to be updated.
  - include the parameters to be updated.

  7. Delete an Appointment
  * DELETE request to URL followed by `/` and the id number for the specific appoint to be deleted.
  - This action will delete the appointment specified and there is no coming back from it. **USE WITH CAUTION**

## Basic information on API
  * Client can only create appointments in the future.
  * Clients can only update future appointments.
  * Appointments that do get updated can only use future dates for the new updated information as well.
  * Appointments will not be created and/or updated if appointment time overlaps with existing appointments.


#### Ruby version
 ruby 2.3.0p0
 Rails 4.2.6

#### Database creation
`rake db:create`

#### Database initialization
`rake db:migrate`
