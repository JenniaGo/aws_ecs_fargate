import unittest
from flask import Flask, jsonify, request

class FlaskMovieSearchTestCase(unittest.TestCase):
    def setUp(self):
        # create a Flask application for testing
        self.app = Flask(__name__)

        @self.app.route('/search')
        def search():
            # get the search query from the request
            query = request.args.get('query')
            # perform the search and get the results
            results = search_movies(query)
            # return the results as a JSON response
            return jsonify(results)

    def tearDown(self):
        # clear the test client and storage after the test
        self.app = None
        clear_storage()

    def test_search(self):
        # create a test client
        client = self.app.test_client()
        # send a GET request to the search endpoint with a query parameter
        response = client.get('/search?query=superman')
        # assert that the response status code is 200 OK
        self.assertEqual(response.status_code, 200)
        # parse the JSON response
        data = response.get_json()
        # assert that the response data is a list
        self.assertIsInstance(data, list)
        # assert that the list is not empty (i.e. there are search results)
        self.assertTrue(len(data) > 0)
        # assert that the first result has the expected structure
        self.assertEqual(set(data[0].keys()), {'id', 'title', 'year', 'rating'})

    def test_search_no_results(self):
        # create a test client
        client = self.app.test_client()
        # send a GET request to the search endpoint with a query that should have no results
        response = client.get('/search?query=asdfghjkl')
        # assert that the response status code is 200 OK
        self.assertEqual(response.status_code, 200)
        # parse the JSON response
        data = response.get_json()
        # assert that the response data is a list
        self.assertIsInstance(data, list)
        # assert that the list is empty (i.e. there are no search results)
        self.assertEqual(len(data), 0)

    def test_search_invalid_input(self):
        # create a test client
        client = self.app.test_client()
        # send a GET request to the search endpoint without a query parameter
        response = client.get('/search')
        # assert that the response status code is 400 Bad Request
        self.assertEqual(response.status_code, 400)
        # parse the JSON response
        data = response.get_json()
        # assert that the response data has the expected structure
        self.assertEqual(set(data.keys()), {'error', 'message'})
        self.assertEqual(data['error'], 'invalid_request')
        self.assertEqual(data['message'], 'Missing required parameter: query')

if __name__ == '__main__':
