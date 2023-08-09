import { component$, type QwikMouseEvent, $ } from "@builder.io/qwik";
import { type DocumentHead, routeLoader$ } from "@builder.io/qwik-city";
import Message from "~/components/message/message.tsx";

export const getApiData = routeLoader$(async (requestEvent) => {
  const apiDomain = requestEvent.env.get("API_DOMAIN");

  try {
    const response = await fetch(`http://${apiDomain}`);
    const data = await response.json();
    return data.message;
  } catch (error) {
    return "ERROR: Failed to load data.";
  }
});

export default component$(() => {
  const apiMessage = getApiData();
  const welcomeBody = `
Courses taught through Graduate School of Education (GSE), Penn Law, and Wharton
cannot be requested through our Course Request Form. For further assistance
setting up your course site please contact the appropriate address below.

<div class="content">
  <ul>
    <li>
      Graduate School of Education (GSE): gse-help@lists.upenn.edu | GSE Site
      Request Form
    </li>
    <li>Law: itshelp@law.upenn.edu Wharton:</li>
    <li>
      courseware@wharton.upenn.edu | Wharton Site Request Info
    </li>
  </ul>
</div>`;
  const updatesBody = `
<div class="block">
  If you encounter any problems using our form, please contact
  canvas@pobox.upenn.edu
</div>

<div class="block">
  If you are requesting a cross-listed course, you only need to request a single
  site through our online form. The form will default to the primary listing for
  the course and pull in all cross-listings automatically. Please direct any
  questions to canvas@pobox.upenn.edu
</div>`;

  return (
    <>
      <div class="section">
        <Message header="Welcome!" body={welcomeBody} style="is-warning" />
        <Message
          header="Important Updates"
          body={updatesBody}
          style="is-info"
        />

        <div class="box is-hidden">
          This message has been loaded from the server: {apiMessage.value}
        </div>

        <div class="box">
          <div class="content">
            <h4>User info</h4>
          </div>
          <table class="table">
            <thead>
              <tr>
                <th>Pennkey</th>
                <th>Penn ID</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>benrosen</td>
                <td>1234567</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div class="box">Request site</div>

        <div class="box">Site Requests</div>

        <div class="box">Current Courses</div>

        <div class="box">
          <div class="content">
            <h4>Canvas Sites</h4>
          </div>
          <table class="table is-striped is-fullwidth">
            <thead>
              <tr>
                <th>Title</th>
                <th>SIS ID</th>
                <th>Request</th>
                <th>Workflow State</th>
              </tr>
            </thead>

            <tbody>
              <tr>
                <td>Test Site I</td>
                <td>1234567</td>
                <td>None</td>
                <td>available</td>
              </tr>

              <tr>
                <td>Test Site II</td>
                <td>1234567</td>
                <td>None</td>
                <td>unpublished</td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </>
  );
});

export const head: DocumentHead = {
  title: "Courseware Web App",
  meta: [
    {
      name: "UPenn Courseware Web App",
      content: "Courseware Web App",
    },
  ],
};
