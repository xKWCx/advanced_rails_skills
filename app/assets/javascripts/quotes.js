(function() {
  $(".js-coverage-info").on("click", function(event) {
    var $coverageModal = $(".js-coverage-modal");

    event.preventDefault();

    $.ajax(event.currentTarget.href, {
      contentType: "application/json",
    }).done(function(data) {
      $coverageModal.find(".js-coverage-modal-title").html(data.name);
      $coverageModal.find(".js-coverage-modal-body").html(data.description);
      $coverageModal.modal("show");
    });
  });
}());
