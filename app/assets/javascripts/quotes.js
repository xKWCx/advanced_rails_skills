(function () {
  $(".js-coverage-info").on("click", function (event) {
    var $coverageModal = $(".js-coverage-modal");

    event.preventDefault();

    $.ajax(event.currentTarget.href, {
      contentType: "application/json",
    }).done(function (data) {
      $coverageModal.find(".js-coverage-modal-title").html(data.name);
      $coverageModal.find(".js-coverage-modal-body").html(data.description);
      $coverageModal.modal("show");
    });
  });

  function updateProducts() {
    var selectedCoverages = [];
    $(".js-coverage-option:checked").each(function () {
      selectedCoverages.push($(this).data("coverage-id"));
    });

    // Save selections to localStorage
    localStorage.setItem(
      "selectedCoverages",
      JSON.stringify(selectedCoverages)
    );

    // Make AJAX call to update product quotes
    $.ajax({
      url: window.location.pathname + "/update_products",
      method: "GET",
      data: { coverage_ids: selectedCoverages },
      dataType: "script",
    });
  }

  // Load saved coverage selections from localStorage and update products
  var savedCoverages = JSON.parse(
    localStorage.getItem("selectedCoverages") || "[]"
  );
  savedCoverages.forEach(function (coverageId) {
    $('.js-coverage-option[data-coverage-id="' + coverageId + '"]').prop(
      "checked",
      true
    );
  });

  // Trigger initial update if there are saved coverages
  if (savedCoverages.length > 0) {
    updateProducts();
  }

  // Handle coverage selection changes
  $(".js-coverage-option").on("change", updateProducts);
})();
