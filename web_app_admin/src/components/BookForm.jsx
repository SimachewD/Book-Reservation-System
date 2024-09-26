import { useState } from 'react';
import { useAuthContext } from '../hooks/useAuth';

const BookForm = () => {
  const [title, setTitle] = useState('');
  const [authorName, setAuthorName] = useState('');
  const [popularityScore, setPopularityScore] = useState(0);
  const [publicationDate, setPublicationDate] = useState('');
  const [coverImage, setCoverImage] = useState();


  const { user } = useAuthContext();

  const handleFileChange = (e) => {
    setCoverImage(e.target.files[0]);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    const formData = new FormData();
    formData.append('title', title);
    formData.append('authorName', authorName);
    formData.append('popularityScore', popularityScore)
    formData.append('publicationDate', publicationDate);
    if (coverImage) {
      formData.append('coverImage', coverImage);
    }

    try {
      const response = await fetch(`http://localhost:10000/my_library/api/admin/addbook`, {
        method: 'POST',
        body: formData,
        headers: { Authorization:`Bearer ${user.token}` },
      });
      if (!response.ok) {
        console.log(response.json())
        throw new Error('Failed to add project');
      }
      // Clear the file input field
      setTitle(''),
      setAuthorName('');
      setPopularityScore(0);
      setPublicationDate('');

      alert('Book added successfully'); 
    } catch (error) { 
      alert(error.message); 
    }
  };

  return (
    <form onSubmit={handleSubmit} className="p-6 bg-white shadow-md rounded-lg">
      <h1 className="text-2xl font-bold mb-6 text-gray-800">Add New Book</h1>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
        <div>
          <label className="block text-gray-700 mb-1">Title</label>
          <input
            type="text"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="border border-gray-300 rounded-lg p-2 w-full"
            required
          />
        </div>
        <div>
          <label className="block text-gray-700 mb-1">Author</label>
          <input
            type="text"
            value={authorName}
            onChange={(e) => setAuthorName(e.target.value)}
            className="border border-gray-300 rounded-lg p-2 w-full"
            required
          />
        </div>
        <div>
          <label className="block text-gray-700 mb-1">Popularity Score(Author)</label>
          <input
            type="number"
            value={popularityScore}
            onChange={(e) => setPopularityScore(e.target.value)}
            className="border border-gray-300 rounded-lg p-2 w-full"
            required
          />
        </div> 
        <div>
          <label className="block text-gray-700 mb-1">Publication Date</label>
          <input
            type="date"
            value={publicationDate}
            onChange={(e) => setPublicationDate(e.target.value)}
            className="border border-gray-300 rounded-lg p-2 w-full"
            required
          />
        </div>
       
        <div className="">
          <label className="block text-gray-700 mb-1">Cover Image</label>
          <input
            type="file"
            name='coverImage'
            onChange={handleFileChange}
            required
            className="border border-gray-300 rounded-lg p-2 w-full"
          />
        </div>
      </div>

      <button type="submit" className="bg-blue-500 text-white p-3 rounded-lg hover:bg-blue-600 transition-colors duration-200">Add Book</button>
    </form>
  );
};

export default BookForm;
