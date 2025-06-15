import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["title", "status"];

  connect() {
    console.log("Task controller connected");
  }

  toggle(event) {
    event.preventDefault();
    event.stopPropagation();

    const checked = event.target.checked;
    const taskId = event.target.dataset.taskId;

    this.updateUI(taskId, checked); // 🟢 Optimistic update

    fetch(`/tasks/${taskId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
      },
      body: JSON.stringify({ task: { completed: checked } }),
    })
      .then((response) => {
        if (!response.ok) throw new Error("Network response was not ok");
        return response.json();
      })
      .then((data) => {
        if (!data.success && data.success !== undefined) {
          this.updateUI(taskId, !checked);
          event.target.checked = !checked;
        }
      })
      .catch((error) => {
        console.error("Error updating task:", error);
        this.updateUI(taskId, !checked);
        event.target.checked = !checked;
      });
  }

  updateUI(taskId, completed) {
    // ✅ อัปเดต title
    const titleElement = this.titleTargets.find((el) => el.dataset.taskId === taskId);
    if (titleElement) {
      titleElement.classList.toggle("line-through", completed);
      titleElement.classList.toggle("text-gray-500", completed);
    }

    // ✅ อัปเดต status badge
    const statusElement = this.statusTargets.find((el) => el.dataset.taskId === taskId);
    if (statusElement) {
      if (completed) {
        statusElement.textContent = "✓ Completed";
        statusElement.classList.remove("bg-blue-100", "text-blue-800");
        statusElement.classList.add("bg-green-100", "text-green-800");
      } else {
        statusElement.textContent = "⏰ In Progress";
        statusElement.classList.remove("bg-green-100", "text-green-800");
        statusElement.classList.add("bg-blue-100", "text-blue-800");
      }
    }
  }
}
