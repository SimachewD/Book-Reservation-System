
const API_URL = '/api/users';

export const fetchUsers = async () => {
  const response = await fetch(API_URL);
  return response.json();
};

export const addUser = async (user) => {
  await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(user),
  });
};
