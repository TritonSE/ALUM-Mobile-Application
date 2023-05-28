import { Types } from "mongoose";
import { InternalError, ServiceError } from "../errors";
import { Session } from "../models";

export async function getUpcomingSession(
  userId: string,
  role: "mentor" | "mentee"
): Promise<Types.ObjectId | null> {
  const now = new Date();

  let matchField: string;

  if (role === "mentor") {
    matchField = "mentorId";
  } else if (role === "mentee") {
    matchField = "menteeId";
  } else {
    throw ServiceError.INVALID_ROLE_WAS_FOUND;
  }

  try {
    const upcomingSession = await Session.findOne({
      startTime: { $gt: now },
      [matchField]: new Types.ObjectId(userId),
    }).sort({ startTime: 1 });

    return upcomingSession?._id;
  } catch (error) {
    throw InternalError.ERROR_FINDING_UPCOMING_SESSION;
  }
}

export async function getLastSession(
  userId: string,
  role: "mentor" | "mentee"
): Promise<Types.ObjectId | null> {
  const now = new Date();

  let matchField: string;

  if (role === "mentor") {
    matchField = "mentorId";
  } else if (role === "mentee") {
    matchField = "menteeId";
  } else {
    throw ServiceError.INVALID_ROLE_WAS_FOUND;
  }

  try {
    const lastSession = await Session.findOne({
      endTime: { $lt: now },
      [matchField]: new Types.ObjectId(userId),
    }).sort({ endTime: -1 });

    return lastSession?._id;
  } catch (error) {
    throw InternalError.ERROR_FINDING_PAST_SESSION;
  }
}

/**
 * Function takes in startTime and endTime date objects and formats it to give:
 * [
 *    "Thursday, April 27, 2023" OR "Thursday, April 27, 2023 - Friday, April 28, 2023",
 *    "5/22"
 *    "2:00 PM"
 *    "2:30 PM"
 * ]
 */
export function formatDateTimeRange(
  startTime: Date,
  endTime: Date
): [string, string, string, string] {
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

  let fullDateString;
  if (startDateString === endDateString) {
    // Thursday, April 27, 2023 at 2:00 PM - 2:30 PM
    fullDateString = startDateString;
  } else {
    fullDateString = endDateString;
  }

  return [fullDateString, dateShortHandString, startTimeString, endTimeString];
  // Thursday, April 27, 2023 at 2:00 PM - Friday, April 28, 2023 at 2:30 PM
}

const startDate = new Date();
const endDate = new Date();
console.log(formatDateTimeRange(startDate, endDate));
