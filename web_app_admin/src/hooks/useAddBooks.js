

import { useEffect, useState } from 'react';
import { useAuthContext } from './useAuth';

const useFetchBooks = () => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const { user } = useAuthContext();


  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await fetch('http://localhost:10000/my_library/api/books', {
          headers: { Authorization:`Bearer ${user.token}` }
          }
        );
        if (!res.ok) {
          throw new Error('Failed to fetch project data');
        }
        const result = await res.json();
        setData(result);
      } catch (error) {
          if (error instanceof Error) {
            setError(error.message);
          }
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  return { data, loading, error };
};

export default useFetchBooks;
