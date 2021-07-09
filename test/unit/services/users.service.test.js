const { createOne, getAll } = require('../../../src/services/users.service');

const userdata = {
  name: 'Seba',
  email: 'seba@mail.com',
  position: 'developer',
};

describe('ssers service unit tests', () => {
  describe('createUser', () => {
    it('should create new user', async () => {
      const user = await createOne(userdata);
      expect(user.ID).toBeDefined();
    });
  });

  describe('getUsers', () => {
    beforeAll(async () => {
      await createOne(userdata);
      await createOne(userdata);
    });

    it('should get users', async () => {
      const data = await getAll();
      expect(data).toBeDefined();
    });
  });
});
