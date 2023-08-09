import { component$ } from "@builder.io/qwik";
import type { DocumentHead } from "@builder.io/qwik-city";

export default component$(() => {
  return (
    <>
      <div class="section">
        <div class="content">
          <h2>Courses</h2>
        </div>
        <table class="table is-striped">
          <thead>
            <tr>
              <th>Section</th>
              <th>Title</th>
              <th>Activity</th>
              <th>Instructor</th>
              <th>Request Status</th>
            </tr>
          </thead>

          <tbody>
            <tr>
              <td>
                <a href="/courses/1">AAMW-5260-401 202330</a>
              </td>
              <td>Material & Methods In Mediterranean Archaeology</td>
              <td>SEM</td>
              <td>lristvet</td>
              <td>Requested</td>
            </tr>

            <tr>
              <td>
                <a href="/courses/2">AAMW-5260-401 202330</a>
              </td>
              <td>Material & Methods In Mediterranean Archaeology</td>
              <td>SEM</td>
              <td>lristvet</td>
              <td>Requested</td>
            </tr>

            <tr>
              <td>
                <a href="/courses/2">AAMW-5260-401 202330</a>
              </td>
              <td>Material & Methods In Mediterranean Archaeology</td>
              <td>SEM</td>
              <td>lristvet</td>
              <td>
                <button class="button is-primary">Request</button>
              </td>
            </tr>
          </tbody>
        </table>
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
