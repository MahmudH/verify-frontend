
describe("Choose a certified company", function () {

  var nonMatchingIdps = '' +
    '<div id="non-matching-idps-warning" class="js-show">' +
      '<a role="button" href="#non-matching-idps">Show all companies</a>' +
    '</div>' +
    '<div id="non-matching-idps" class="js-hidden"></div>';

  var $dom;
  $('html').addClass('js-enabled');

  beforeEach(function () {
    $dom = $('<div>' + nonMatchingIdps + '</div>');
    $(document.body).append($dom);
    GOVUK.chooseACertifiedCompany.init();
  });

  afterEach(function () {
    $dom.remove();
  });

  it("should show the non-matching IDP's when 'show-all' is clicked", function () {
    $('#non-matching-idps-warning a').click();
    expect($('#non-matching-idps-warning').is('.hidden')).toBe(true);
    expect($('#non-matching-idps').is('.js-hidden')).toBe(false);
  });
});
