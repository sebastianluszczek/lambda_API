const { res201, res500 } = require('../utils/error.utils');

const { createOne } = require('../services/users.service');

exports.handler = async event => {
  const data = JSON.parse(event.body);

  try {
    const user = await createOne(data);

    return res201(user);
  } catch (error) {
    return res500(error);
  }
};
