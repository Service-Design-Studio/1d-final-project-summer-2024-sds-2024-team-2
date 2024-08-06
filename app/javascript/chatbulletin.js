$(document).ready(function () {
  document
    .getElementById("bulletinButton")
    .addEventListener("click", function () {
      var bulletinDisplay = document.getElementById("bulletinDisplay");
      if (
        bulletinDisplay.style.display === "none" ||
        bulletinDisplay.style.display === ""
      ) {
        bulletinDisplay.style.display = "flex";
      } else {
        bulletinDisplay.style.display = "none";
      }
    });
  // JavaScript to toggle chat display
  document.querySelectorAll(".chatButton").forEach(function (button) {
    button.addEventListener("click", function () {
      document.getElementById("chatDisplay").style.display = "flex";
    });
  });

  // Define the function to handle the close button click
  function handleCloseButtonClick() {
    document.getElementById("chatDisplay").style.display = "none";
  }

  document
    .getElementById("closeButtonChat")
    .addEventListener("click", handleCloseButtonClick);

  // Attach the function to the close button click event

  // Function to handle form submission
  function handleFormSubmission() {
    adjustChatInputHeight();
    const userInput = $("#user-input").val();
    if (userInput.trim() === "") return;

    appendMessage("user", "You", userInput);
    $("#user-input").val("");
    resetChatInputHeight(); // Reset the height after submission

    const thinkingMessage = $(
      '<div class="chat-message bot text-muted">Bot: thinking . . . </div>'
    );
    $("#chat-box").append(thinkingMessage);

    $.ajax({
      url: "/chatbot",
      method: "POST",
      data: { message: userInput },
      success: function (response) {
        thinkingMessage.remove();
        // Function to process the response reply
        function processReply(reply) {
          // Replace **bold** with <strong>bold</strong>
          // Replace *pointer* with <em>pointer</em>
          reply = reply.replace(/\*\*(.*?)\*\*/g, "<strong>$1</strong>");
          reply = reply.replace(/\* /g, "<br>");
          return reply;
        }

        // Process the response reply
        const processedReply = processReply(response.reply);

        appendMessage("bot", "Bot", processedReply);
      },
      error: function () {
        thinkingMessage.remove();
        appendMessage("bot", "Bot", "Error, please try again.");
      },
    });
  }

  // Attach the function to the form submit event
  $("#chat-form").on("submit", function (e) {
    e.preventDefault();
    handleFormSubmission();
  });

  // Attach the function to the return key press event
  $("#user-input").on("keypress", function (e) {
    if (e.which === 13 && !e.shiftKey) {
      e.preventDefault();
      handleFormSubmission();
    }
  });

  function appendMessage(role, name, text) {
    const chatBox = $("#chat-box");
    const messageHtml = `<div class="chat-message ${role}">${text}</div>`;
    chatBox.append(messageHtml);
    chatBox.scrollTop(chatBox[0].scrollHeight);
  }
  const chatInput = document.getElementById("user-input");
  // Define the function to adjust the chat input height
  function adjustChatInputHeight() {
    chatInput.style.height = "auto";
    chatInput.style.height = chatInput.scrollHeight + "px";
  }
  function resetChatInputHeight() {
    chatInput.style.height = "auto";
  }
  // Attach the function to the input event listener
  chatInput.addEventListener("input", adjustChatInputHeight);
});
