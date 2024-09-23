const express = require('express');
const cors = require('cors');

// App configuration
const app = express();
const port = 3000;

// Middleware
app.use(express.json());
app.use(cors());

// In-memory database for posts
let postsList = [
    {
        id: "1", // Change this to a string
        uniqueId: "post_1687452800000",
        content: "Just had an amazing day at the beach!",
        timestamp: 1687452800000,
        userId: 1,
        comments: []
    },
    {
        id: "2", // Change this to a string
        uniqueId: "post_1687539200000",
        content: "Check out this beautiful sunset!",
        imageUrl: "https://images.pexels.com/photos/11659750/pexels-photo-11659750.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        timestamp: 1687539200000,
        userId: 2,
        comments: []
    }
];

// API Routes

// Get all posts
app.get('/api/v1/posts', (req, res) => {
    res.json(postsList);
});

// Get a single post by ID
app.get('/api/v1/posts/:id', (req, res) => {
    const postId = parseInt(req.params.id);
    const post = postsList.find(post => post.id === postId);

    if (post) {
        res.json(post);
    } else {
        res.status(404).json({ message: 'Post not found' });
    }
});

// Add a new post
app.post('/api/v1/posts', (req, res) => {
    const { content, userId, imageUrl } = req.body;
    if (!content || !userId) {
        return res.status(400).json({ message: 'Content and userId are required' });
    }

    const newPost = {
        id: postsList.length + 1,
        uniqueId: "post_" + Date.now(),
        content: content,
        imageUrl: imageUrl || null,
        timestamp: Date.now(),
        userId: userId,
        comments: [] // Initialize with an empty comments array
    };
    postsList.push(newPost);
    res.status(201).json(newPost);
});

// Update a post
app.put('/api/v1/posts/:id', (req, res) => {
    const postId = parseInt(req.params.id);
    const { content, userId, imageUrl } = req.body;

    const postIndex = postsList.findIndex(post => post.id === postId);
    if (postIndex !== -1) {
        postsList[postIndex] = {
            ...postsList[postIndex],
            content: content || postsList[postIndex].content,
            userId: userId || postsList[postIndex].userId,
            imageUrl: imageUrl || postsList[postIndex].imageUrl,
            timestamp: Date.now()
        };
        res.json(postsList[postIndex]);
    } else {
        res.status(404).json({ message: 'Post not found' });
    }
});

// Delete a post
app.delete('/api/v1/posts/:id', (req, res) => {
    const postId = parseInt(req.params.id);

    const postIndex = postsList.findIndex(post => post.id === postId);
    if (postIndex !== -1) {
        postsList.splice(postIndex, 1);
        res.json({ message: 'Post deleted successfully' });
    } else {
        res.status(404).json({ message: 'Post not found' });
    }
});

// Add a comment to a post
app.post('/api/v1/posts/:id/comments', (req, res) => {
    const postId = parseInt(req.params.id);
    const { content, userId } = req.body;
    const post = postsList.find(post => post.id === postId);

    if (post) {
        const newComment = {
            id: post.comments.length + 1,
            content: content,
            userId: userId,
            timestamp: Date.now(),
        };
        post.comments.push(newComment);
        res.status(201).json(newComment);
    } else {
        res.status(404).json({ message: 'Post not found' });
    }
});

// Update a comment on a post
app.put('/api/v1/posts/:postId/comments/:commentId', (req, res) => {
    const postId = parseInt(req.params.postId);
    const commentId = parseInt(req.params.commentId);
    const { content, userId } = req.body;
    const post = postsList.find(post => post.id === postId);

    if (post) {
        const commentIndex = post.comments.findIndex(comment => comment.id === commentId);
        if (commentIndex !== -1) {
            post.comments[commentIndex] = {
                ...post.comments[commentIndex],
                content: content || post.comments[commentIndex].content,
                userId: userId || post.comments[commentIndex].userId,
                timestamp: Date.now()
            };
            res.json(post.comments[commentIndex]);
        } else {
            res.status(404).json({ message: 'Comment not found' });
        }
    } else {
        res.status(404).json({ message: 'Post not found' });
    }
});

// Delete a comment on a post
app.delete('/api/v1/posts/:postId/comments/:commentId', (req, res) => {
    const postId = parseInt(req.params.postId);
    const commentId = parseInt(req.params.commentId);
    const post = postsList.find(post => post.id === postId);

    if (post) {
        const commentIndex = post.comments.findIndex(comment => comment.id === commentId);
        if (commentIndex !== -1) {
            post.comments.splice(commentIndex, 1);
            res.json({ message: 'Comment deleted successfully' });
        } else {
            res.status(404).json({ message: 'Comment not found' });
        }
    } else {
        res.status(404).json({ message: 'Post not found' });
    }
});

// Start server
app.listen(port, () => console.log(`Server running at http://localhost:${port}`));
