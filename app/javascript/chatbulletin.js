$(document).ready(function () {
  // JavaScript to toggle chat display
  document.getElementById("chatButton").addEventListener("click", function () {
    document.getElementById("chatDisplay").style.display = "flex";
    document.getElementById("BulletinButton").style.display = "flex";
  });

  document.getElementById("closeButton").addEventListener("click", function () {
    document.getElementById("chatDisplay").style.display = "none";
    document.getElementById("BulletinButton").style.display = "none";
  });

  $("#chat-form").on("submit", function (e) {
    e.preventDefault();
    const userInput = $("#user-input").val();
    if (userInput.trim() === "") return;

    appendMessage("user", "You", userInput);
    $("#user-input").val("");
    const thinkingMessage = $(
      '<div class="chat-message bot text-muted">Bot: ...thinking</div>'
    );
    $("#chat-box").append(thinkingMessage);

    $.ajax({
      url: "/chatbot",
      method: "POST",
      data: { message: userInput },
      success: function (response) {
        thinkingMessage.remove();
        appendMessage("bot", "Bot", response.reply);
      },
      error: function () {
        thinkingMessage.remove();
        appendMessage("bot", "Bot", "Error, please try again.");
      },
    });
  });

  function appendMessage(role, name, text) {
    const chatBox = $("#chat-box");
    const messageHtml = `<div class="chat-message ${role}"><strong>${name}:</strong> ${text}</div>`;
    chatBox.append(messageHtml);
    chatBox.scrollTop(chatBox[0].scrollHeight);
  }
});
