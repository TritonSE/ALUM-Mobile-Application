import { ServiceError } from "../errors";

/**
 * This function retrieves information about a calendly event
 * via the get route on the calendly API
 */

async function getCalendlyEventDate(uri: string, accessToken: string) {
  const regex = /\/scheduled_events\/(\w+-\w+-\w+-\w+-\w+)/;
  const match = uri.match(regex);

  let uuid = "";
  if (match) {
    uuid = match[1];
  } else {
    throw ServiceError.INVALID_URI;
  }

  try {
    const response = await fetch(`https://api.calendly.com/scheduled_events/${uuid}`, {
      method: "GET",
      headers: {
        Authorization: `Bearer ${accessToken}`,
        "Content-Type": "application/json",
      },
    });
    const data = response.json();
    return await data;
  } catch (e) {
    console.log(e);
    throw ServiceError.ERROR_GETTING_EVENT_DATA;
  }
}

async function deleteCalendlyEvent(uri: string, accessToken: string) {
  const regex = /\/scheduled_events\/(\w+-\w+-\w+-\w+-\w+)/;
  const match = uri.match(regex);

  let uuid = "";
  if (match) {
    uuid = match[1];
  } else {
    throw ServiceError.INVALID_URI;
  }
  try {
    const options = {
      method: "POST",
      headers: {
        Authorization: `Bearer ${accessToken}`,
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ reason: "string" }),
    };
    const response = await fetch(`https://api.calendly.com/scheduled_events/${uuid}/cancellation`, options)
    const data = response.json()
    return await data;
  } catch (e) {
    console.log(e);
    throw ServiceError.ERROR_DELETING_EVENT;
  }

}

export { getCalendlyEventDate, deleteCalendlyEvent };
