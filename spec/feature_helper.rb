require 'rails_helper'
require 'capybara/rspec'
require 'webmock/rspec'

def set_cookies(hash)
  hash.each do |key, value|
    Capybara.current_session.driver.browser.set_cookie "#{key}=#{value}"
  end
end


def api_transactions_endpoint
  'http://localhost:50190/api/transactions'
end

def stub_transactions_list
  transactions = {
      'public' => [
          {'simpleId' => 'test-rp', 'entityId' => 'some-entity-id', 'homepage' => 'http://localhost:50130/test-rp'}
      ],
      'private' => []
  }
  stub_request(:get, api_transactions_endpoint).to_return(body: transactions.to_json, status: 200)
end


def create_session_start_time_cookie
  DateTime.now.to_i * 1000
end

def api_uri(path)
  "#{API_HOST}/api/#{path}"
end

def expect_feedback_source_to_be(page, source)
  expect(page).to have_link 'feedback', href: "/feedback?feedback-source=#{source}"
end

def set_cookies(hash)
  hash.each do |key, value|
    Capybara.current_session.driver.browser.set_cookie "#{key}=#{value}"
  end
end

def create_cookie_hash
  {
      CookieNames::SECURE_COOKIE_NAME => 'my-secure-cookie',
      CookieNames::SESSION_STARTED_TIME_COOKIE_NAME => create_session_start_time_cookie,
      CookieNames::SESSION_ID_COOKIE_NAME => 'my-session-id-cookie',
  }
end

def set_session_cookies
  cookie_hash = create_cookie_hash
  set_cookies(cookie_hash)
  cookie_hash
end
