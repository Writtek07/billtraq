// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


require("@rails/ujs").start()
//require("turbolinks").start()
// require("@rails/activestorage").start()
require("channels")
require("bootstrap")
require("@popperjs/core")
require("../stylesheets/application.scss")
// import 'bootstrap'
import 'bootstrap-icons/font/bootstrap-icons.css'
import "chartkick"
//= require highcharts
//= require chartkick

// Import the specific modules you may need (Modal, Alert, etc)

// The stylesheet location we created earlier

var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
})

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

//After using post method on form submission, url only showed admin/dashboard on click.
//So to make it look like we actually fired a search, I am modifying the url on form submission from admin/dashboard.
//NOTE- params aren't effected hence justed javascript to just append str to url.

$(document).ready(function() {
    $('#invoice-chart-form').submit(function(e) {
      e.preventDefault(); // prevent the form from submitting

      // append a random string to the form URL
      var randomString = Math.random().toString(36).substring(2,9);
      var formUrl = $(this).attr('action') + '?;search_chart_filter=' + randomString;
      $(this).attr('action', formUrl);

      // submit the form
      this.submit();
    });

    $('#invoice-more-data-form').submit(function(e) {
      e.preventDefault(); // prevent the form from submitting

      // append a random string to the form URL
      var randomString = Math.random().toString(36).substring(2,10);
      var formUrl = $(this).attr('action') + '?;search_invoice_filter=' + randomString;
      $(this).attr('action', formUrl);

      // submit the form
      this.submit();
    });

    // ################## Sidebar starts ##################
    $('#sidebarCollapse').on('click', function () {
      $('#sidebar').toggleClass('active');
    });
    const sidebarHeader = document.querySelector('.sidebar-header');
        const sidebar = document.getElementById('sidebar');
        
        sidebarHeader.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });
    // ################## Sidebar end ##################

    // ################## cheque data input fields starts ##################
    var paymentModeSelect = document.getElementById('payment_mode_select');

    // Function to show or hide the cheque fields based on the selected value
    function toggleChequeFields() {
      var chequeFields = document.querySelector('.cheque-fields');
      var selectedValue = paymentModeSelect.value;

      // Show the cheque fields if the selected value is "Cheque", hide them otherwise
      if (selectedValue === 'Cheque') {
        chequeFields.style.display = 'block';
      } else {
        chequeFields.style.display = 'none';
      }
    }

    // Initial call to set the visibility based on the default value
    toggleChequeFields();

    // Add an event listener to the payment_mode select to toggle the cheque fields
    paymentModeSelect.addEventListener('change', toggleChequeFields);
    
    // ################## cheque data input fields ends ##################

  });


//Adding invoices items with modal via AJAX.(Pending)
//$(document).ready(function() {
//    $('[data-toggle="modal"]').click(function() {
//      $.ajax({
//        url: '<%= new_invoice_particular_path(@invoice) %>',
//        success: function(data) {
//          console.log(data);
//          $('#new-invoice-particular-form').html(data);
//        }
//      });
//    });
//  });