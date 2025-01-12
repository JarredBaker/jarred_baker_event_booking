import consumer from "./consumer";

document.addEventListener("turbo:load", () => {
  const userId = document.getElementById("ticket-status")?.dataset.userId;

  if (userId) {
    consumer.subscriptions.create({channel: "TicketStatusChannel", user_id: userId}, {
      received(data) {
        const messageContainer = document.getElementById("ticket-status-message");
        messageContainer.innerHTML = `<div class="${data.status === "success" ? 'alert-info' : 'alert-danger bg-slate-900'}">${data.message}</div>`;
      }
    });
  }
});