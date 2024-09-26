

import { useEffect, useState } from 'react';
import { useAuthContext } from './useAuth';

const useFetchUsers= () => {
  const [data, setData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const { user } = useAuthContext();


  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await fetch('http://localhost:10000/my_library/api/admin/users', {
          headers: { Authorization:`Bearer ${user.token}` }
          }
        );
        if (!res.ok) {
          throw new Error('Failed to fetch user data');
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

export default useFetchUsers;
