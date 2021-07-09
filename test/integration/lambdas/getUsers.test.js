const getUsers = require('../../../src/lambdas/getUsers');
const { createOne, getAll } = require('../../../src/services/users.service');
const {
  APIGatewayRequest,
  isApiGatewayResponse,
} = require('../../test.helpers');

const sampleData = [
  {
    name: 'Seba',
    email: 'seba@mail.com',
    position: 'developer',
  },
  {
    name: 'Niki',
    email: 'niki@mail.com',
    position: 'intern',
  },
];

describe('get all users integration tests', () => {
  test('it should return an API Gateway response', async () => {
    const event = APIGatewayRequest({});

    const res = await getUsers.handler(event);

    expect(res).toBeDefined();
    expect(isApiGatewayResponse(res)).toBe(true);
  });

  test('shoudl return a 200 with users list', async () => {
    // create users inside table
    for (i in sampleData) {
      await createOne(i);
    }
    const event = APIGatewayRequest({});
    const res = await getUsers.handler(event);

    const body = JSON.parse(res.body);

    expect(res.statusCode).toBe(200);
    expect(Array.isArray(body.data)).toBe(true);
    expect(body.data.length).toBe(2);
  });
});
