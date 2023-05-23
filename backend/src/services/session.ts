/**
 * Function takes in startTime and endTime date objects and formats it to give:
 * [
 *    "Thursday, April 27, 2023" OR "Thursday, April 27, 2023 - Friday, April 28, 2023",
 *    "5/22"
 *    "2:00 PM"
 *    "2:30 PM"
 * ]
 */
export function formatDateTimeRange(startTime: Date, endTime: Date): [string, string, string, string] {
  const dateOptions: Intl.DateTimeFormatOptions = {
    weekday: "long",
    year: "numeric",
    month: "long",
    day: "numeric",
  };

  const timeOptions: Intl.DateTimeFormatOptions = {
    hour: "numeric",
    minute: "numeric",
    hour12: true,
  };

  const dateShortHandOptions: Intl.DateTimeFormatOptions = {
    month: "numeric",
    day: "numeric",
  };

  const startDateString = startTime.toLocaleDateString("en-US", dateOptions);
  const startTimeString = startTime.toLocaleTimeString("en-US", timeOptions);
  const endDateString = endTime.toLocaleDateString("en-US", dateOptions);
  const endTimeString = endTime.toLocaleTimeString("en-US", timeOptions);
  const dateShortHandString = startTime.toLocaleDateString("en-US", dateShortHandOptions);

  let fullDateString 
  if (startDateString === endDateString) {
    // Thursday, April 27, 2023 at 2:00 PM - 2:30 PM
    fullDateString = startDateString
  } else {
    fullDateString = endDateString
  }
  
  return [fullDateString, dateShortHandString, startTimeString, endTimeString]
  // Thursday, April 27, 2023 at 2:00 PM - Friday, April 28, 2023 at 2:30 PM
}

const startDate = new Date();
const endDate = new Date();
console.log(formatDateTimeRange(startDate, endDate))