const API_URL = '/api/books';

export const fetchBooks = async () => {
  const response = await fetch(API_URL);
  return response.json();
};

export const addBook = async (book) => {
  await fetch(API_URL, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(book),
  });
};
