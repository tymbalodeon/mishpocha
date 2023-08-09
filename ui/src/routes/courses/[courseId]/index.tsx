import { component$ } from "@builder.io/qwik";
import { type DocumentHead, useLocation } from "@builder.io/qwik-city";

export default component$(() => {
  const courseId = useLocation().params.courseId;
  return (
    <>
      <div class="section">
        <div class="content">
          <h2>Course {courseId}</h2>
        </div>
        <div class="box">
          <a href="/courses/1">AAMW-5260-401 202330</a>
          <p>Material & Methods In Mediterranean Archaeology</p>
          <p>SEM</p>
          <p>lristvet</p>
          <p>Requested</p>
        </div>
        <p class="mb-4">
          The default tile is provided below. If you wish to modify it, please
          provide the new value in the box below.
        </p>
        <div class="field">
          <label class="label">Title override</label>
          <div class="control">
            <input class="input" type="text" placeholder="AAMW" />
          </div>
        </div>
        <div class="field">
          <div class="control">
            <label class="checkbox">
              <input type="checkbox" /> LPS Online
            </label>
          </div>
        </div>
        <div class="field">
          <label class="label">Canvas site</label>
          <div class="control">
            <div class="select">
              <select>
                <option>Select a Canvas site...</option>
                <option>With options</option>
              </select>
            </div>
          </div>
        </div>
        <div class="field">
          <div class="control">
            <label class="checkbox">
              <input type="checkbox" /> Exclude announcements
            </label>
          </div>
        </div>
        <div class="field">
          <div class="control">
            <label class="checkbox">
              <input type="checkbox" /> Reserves
            </label>
          </div>
        </div>
        <div class="box">
          <div class="field">
            <label class="label">User</label>
            <div class="control">
              <input class="input" type="text" placeholder="pennkey" />
            </div>
            <label class="label">Role</label>
            <div class="control">
              <div class="select">
                <select>
                  <option>Select a role...</option>
                  <option>TA</option>
                  <option>Designer</option>
                  <option>Librarian</option>
                  <option>Instructor</option>
                </select>
              </div>
            </div>
          </div>
        </div>
        <div class="field">
          <label class="label">Additional instructions</label>
          <div class="control">
            <textarea class="textarea" placeholder="Textarea"></textarea>
          </div>
        </div>
        <div class="field">
          <label class="label">Admin notes</label>
          <div class="control">
            <textarea class="textarea" placeholder="Textarea"></textarea>
          </div>
        </div>
        <div class="field is-grouped">
          <div class="control">
            <button class="button is-link">Submit</button>
          </div>
          <div class="control">
            <button class="button is-link is-light">Cancel</button>
          </div>
        </div>{" "}
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
