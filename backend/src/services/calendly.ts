import { ServiceError, ValidationError } from "../errors";

/**
 * This function gets calendly event data. See get event route
 * on Calendly API
 * @param uri
 * @param accessToken
 * @returns Returns the full request body from calendly
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

/**
 * This function deletes a calendly event
 * @param uri
 * @param accessToken
 * @returns The request body (see calendly API cancel event route)
 */
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
    };
    const response = await fetch(
      `https://api.calendly.com/scheduled_events/${uuid}/cancellation`,
      options
    );
    const data = response.json();
    return await data;
  } catch (e) {
    console.log(e);
    throw ServiceError.ERROR_DELETING_EVENT;
  }
}

async function validateCalendlyAccessToken(accessToken: string) {
  try {
    console.log("ac", accessToken);
    const response = await fetch(`https://api.calendly.com/users/me`, {
      method: "GET",
      headers: {
        Authorization: `Bearer ${accessToken}`,
        "Content-Type": "application/json",
      },
    });

    if (!response.ok) {
      throw ValidationError.INVALID_CALENDLY_PERSONAL_ACCESS_TOKEN;
    }
  } catch (e) {
    throw ValidationError.INVALID_CALENDLY_PERSONAL_ACCESS_TOKEN;
  }
}

export { getCalendlyEventDate, validateCalendlyAccessToken, deleteCalendlyEvent };
