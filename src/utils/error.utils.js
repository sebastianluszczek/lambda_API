const headers = {
  'Content-Type': 'application/json',
  'Access-Control-Allow-Methods': '*',
  'Access-Control-Allow-Origin': '*',
};

exports.res200 = (data = {}) => ({
  headers,
  statusCode: 200,
  body: JSON.stringify({ data }),
});
exports.res201 = (data = {}) => ({
  headers,
  statusCode: 201,
  body: JSON.stringify({ data }),
});
exports.res204 = (data = {}) => ({
  headers,
  statusCode: 204,
});
exports.res400 = message => ({
  headers,
  statusCode: 400,
  body: JSON.stringify({ message }),
});
exports.res500 = message => ({
  headers,
  statusCode: 500,
  body: JSON.stringify({ message }),
});
