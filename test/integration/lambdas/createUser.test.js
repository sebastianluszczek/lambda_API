const createUser = require('../../../src/lambdas/createUser');
const {
  APIGatewayRequest,
  isApiGatewayResponse,
} = require('../../test.helpers');

describe('create user integration tests', () => {
  test('it shoudl take a body and return an API Gateway response', async () => {
    const event = APIGatewayRequest({
      body: {
        name: 'tom',
        score: 43,
      },
    });

    const res = await createUser.handler(event);

    expect(res).toBeDefined();
    expect(isApiGatewayResponse(res)).toBe(true);
  });

  test('shoudl return a 201 with user if user is valid', async () => {
    const event = APIGatewayRequest({
      body: {
        name: 'tom',
        score: 43,
      },
    });
    const res = await createUser.handler(event);

    expect(res.statusCode).toBe(201);
    const body = JSON.parse(res.body);
    expect(body).toMatchObject({
      data: {
        name: 'tom',
        score: 43,
      },
    });
  });
});
