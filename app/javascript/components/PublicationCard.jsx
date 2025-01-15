import React from 'react';
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import {
    Clock,
    Share2,
    BookmarkPlus,
    ArrowUpRight,
    User,
    ThumbsUp,
    MessageSquare
} from 'lucide-react';

const PublicationCard = ({ publication }) => {
    const [interactions, setInteractions] = useState({
        likes_count: publication.likes_count,
        comments_count: publication.comments_count,
        bookmarks_count: publication.bookmarks_count,
        isLiked: publication.is_liked_by_current_user,
        isBookmarked: publication.is_bookmarked_by_current_user
    });
    const [showComments, setShowComments] = useState(false);
    const [commentText, setCommentText] = useState('');
    const handleLike = async () => {
        try {
            const response = await fetch(`/api/publications/${publication.id}/like`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('[name="csrf-token"]')?.content
                }
            });
            const data = await response.json();
            setInteractions(prev => ({
                ...prev,
                likes_count: data.likes_count,
                isLiked: data.liked
            }));
        } catch (error) {
            console.error('Error toggling like:', error);
        }
    };

    const handleBookmark = async () => {
        try {
            const response = await fetch(`/api/publications/${publication.id}/bookmark`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('[name="csrf-token"]')?.content
                }
            });
            const data = await response.json();
            setInteractions(prev => ({
                ...prev,
                bookmarks_count: data.bookmarks_count,
                isBookmarked: data.bookmarked
            }));
        } catch (error) {
            console.error('Error toggling bookmark:', error);
        }
    };

    const handleComment = async () => {
        if (!commentText.trim()) return;

        try {
            const response = await fetch(`/api/publications/${publication.id}/comment`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-CSRF-Token': document.querySelector('[name="csrf-token"]')?.content
                },
                body: JSON.stringify({ content: commentText })
            });
            const data = await response.json();
            setInteractions(prev => ({
                ...prev,
                comments_count: data.comments_count
            }));
            setCommentText('');
        } catch (error) {
            console.error('Error posting comment:', error);
        }
    };

    const {
        title,
        summary,
        category,
        author,
        read_time,
        sources,
        created_at,
        ai_generated,
        likes_count = 0,
        comments_count = 0
    } = publication;

    return (
        <Card className="hover:shadow-lg transition-shadow">
            <CardHeader>
                <div className="flex justify-between items-start">
                    <div>
                        <div className="flex flex-wrap gap-2 mb-2">
                            <Badge variant="outline">
                                {category}
                            </Badge>
                            {ai_generated && (
                                <Badge variant="secondary" className="flex items-center gap-1">
                                    <span className="w-2 h-2 bg-blue-400 rounded-full animate-pulse"></span>
                                    AI Generated
                                </Badge>
                            )}
                        </div>
                        <CardTitle className="text-2xl font-bold hover:text-blue-600 cursor-pointer">
                            {title}
                        </CardTitle>
                    </div>
                    <div className="flex items-center gap-2 text-sm text-gray-500">
                        <Clock className="h-4 w-4" />
                        <span>{read_time} min read</span>
                    </div>
                </div>
            </CardHeader>

            <CardContent>
                <p className="text-gray-600 mb-4">{summary}</p>

                <div className="flex flex-wrap items-center justify-between gap-4 mt-6">
                    <div className="flex items-center gap-2 text-sm text-gray-600">
                        <User className="h-4 w-4" />
                        <span>By {author.full_name}</span>
                    </div>

                    <div className="flex items-center gap-4">
                        <Button variant="ghost" size="sm" className="text-gray-500 hover:text-blue-600">
                            <ThumbsUp className="h-4 w-4 mr-1" />
                            {likes_count}
                        </Button>
                        <Button variant="ghost" size="sm" className="text-gray-500 hover:text-blue-600">
                            <MessageSquare className="h-4 w-4 mr-1" />
                            {comments_count}
                        </Button>
                        <Button variant="ghost" size="sm" className="text-gray-500 hover:text-blue-600">
                            <BookmarkPlus className="h-4 w-4" />
                        </Button>
                        <Button variant="ghost" size="sm" className="text-gray-500 hover:text-blue-600">
                            <Share2 className="h-4 w-4" />
                        </Button>
                    </div>
                </div>
            </CardContent>

            <CardFooter className="flex justify-between items-center pt-4 border-t">
                <div className="flex flex-wrap gap-4">
                    {sources.map((source, index) => (
                        <a
                            key={index}
                            href={source.url}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="flex items-center text-sm text-blue-600 hover:text-blue-800"
                        >
                            <span>{source.name}</span>
                            <ArrowUpRight className="h-4 w-4 ml-1" />
                        </a>
                    ))}
                </div>
                <div className="text-sm text-gray-500">
                    {new Date(created_at).toLocaleDateString('en-US', {
                        year: 'numeric',
                        month: 'long',
                        day: 'numeric'
                    })}
                </div>
            </CardFooter>
        </Card>
    );
};

export default PublicationCard;