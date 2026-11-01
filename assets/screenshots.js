// Adds a Light / Dark switch to every <picture class="screenshot">. A
// screenshot follows the system color mode until the reader picks one, and
// the choice applies to all screenshots and is remembered.
(function () {
  var KEY = "screenshot-theme";
  var pictures = document.querySelectorAll("picture.screenshot");
  if (!pictures.length) return;

  var system = window.matchMedia("(prefers-color-scheme: dark)");
  var stored = null;
  try { stored = localStorage.getItem(KEY); } catch (e) {}

  function current() {
    return stored || (system.matches ? "dark" : "light");
  }

  function apply() {
    var theme = current();
    pictures.forEach(function (picture) {
      var source = picture.querySelector('source[data-theme="dark"]');
      if (source) source.media = theme === "dark" ? "all" : "not all";
    });
    document.querySelectorAll(".screenshot-switch button").forEach(function (button) {
      button.setAttribute("aria-pressed", String(button.value === theme));
    });
  }

  function choose(theme) {
    stored = theme;
    try { localStorage.setItem(KEY, theme); } catch (e) {}
    apply();
  }

  pictures.forEach(function (picture) {
    var group = document.createElement("div");
    group.className = "screenshot-switch BtnGroup";
    group.setAttribute("role", "group");
    group.setAttribute("aria-label", "Screenshot theme");
    ["light", "dark"].forEach(function (theme) {
      var button = document.createElement("button");
      button.type = "button";
      button.className = "btn btn-sm BtnGroup-item";
      button.value = theme;
      button.textContent = theme === "light" ? "Light" : "Dark";
      button.addEventListener("click", function () { choose(theme); });
      group.appendChild(button);
    });
    var anchor = picture.closest(".Box") || picture;
    anchor.parentNode.insertBefore(group, anchor);
  });

  if (system.addEventListener) system.addEventListener("change", apply);
  apply();
})();
