import React, { useState, useEffect } from 'react';
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { AlertCircle, ArrowUpRight, Clock, User } from 'lucide-react';
import { Alert, AlertDescription } from '@/components/ui/alert';

const PublicationsFeed = () => {
    const [publications, setPublications] = useState([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const fetchPublications = async () => {
            try {
                const response = await fetch('/api/publications?ai_generated=true');
                const data = await response.json();
                setPublications(data);
                setLoading(false);
            } catch (err) {
                setError('Failed to load publications');
                setLoading(false);
            }
        };

        fetchPublications();
    }, []);

    if (loading) {
        return (
            <div className="flex justify-center items-center h-64">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-blue-500"></div>
            </div>
        );
    }

    if (error) {
        return (
            <Alert variant="destructive">
                <AlertCircle className="h-4 w-4" />
                <AlertDescription>{error}</AlertDescription>
            </Alert>
        );
    }

    return (
        <div className="space-y-6">
            {publications.map((publication) => (
                <Card key={publication.id} className="hover:shadow-lg transition-shadow">
                    <CardHeader>
                        <div className="flex justify-between items-start">
                            <div>
                                <div className="flex space-x-2 mb-2">
                                    <Badge variant="outline">
                                        {publication.category}
                                    </Badge>
                                    {publication.ai_generated && (
                                        <Badge variant="secondary">
                                            AI Generated
                                        </Badge>
                                    )}
                                </div>
                                <CardTitle className="text-2xl font-bold hover:text-blue-600">
                                    {publication.title}
                                </CardTitle>
                            </div>
                            <div className="flex items-center space-x-2 text-sm text-gray-500">
                                <Clock className="h-4 w-4" />
                                <span>{publication.read_time} min read</span>
                            </div>
                        </div>
                    </CardHeader>

                    <CardContent>
                        <p className="text-gray-600 mb-4">{publication.summary}</p>
                        <div className="flex items-center space-x-2 text-sm text-gray-500">
                            <User className="h-4 w-4" />
                            <span>By {publication.author.full_name}</span>
                        </div>
                    </CardContent>

                    <CardFooter className="flex justify-between items-center pt-4 border-t">
                        <div className="flex space-x-4">
                            {publication.sources.map((source, index) => (
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
                            {new Date(publication.created_at).toLocaleDateString('en-US', {
                                year: 'numeric',
                                month: 'long',
                                day: 'numeric'
                            })}
                        </div>
                    </CardFooter>
                </Card>
            ))}
        </div>
    );
};

export default PublicationsFeed;