$(document).ready(function () {
  // JavaScript to toggle chat display
  document.getElementById("chatButton").addEventListener("click", function () {
    document.getElementById("chatDisplay").style.display = "flex";
    console.log(document.getElementById("chatDisplay").style.display);
    document.getElementById("BulletinButton").style.display = "flex";
  });
    
  document.getElementById("bulletinButton").addEventListener("click", function () {
    document.getElementById("bulletinDisplay").style.display = "flex";
    console.log(document.getElementById("bulletinDisplay").style.display);
    document.getElementById("bulletinButton").style.display = "flex";
  });

    // Define the function to handle the close button click
    function handleCloseButtonClick() {
    document.getElementById("chatDisplay").style.display = "none";
    document.getElementById("bulletinDisplay").style.display = "none";
    document.getElementById("BulletinButton").style.display = "none";
    }

    // Attach the function to the close button click event
    document.getElementById("closeButtonBulletin").addEventListener("click", handleCloseButtonClick);
    document.getElementById("closeButtonChat").addEventListener("click", handleCloseButtonClick);
    
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
        appendMessage("bot", "Bot", response.reply);
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
