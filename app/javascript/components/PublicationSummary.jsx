import React, { useState } from 'react';
import { Card, CardHeader, CardContent } from '@/components/ui/card';
import { BookOpen, Tag, BarChart3 } from 'lucide-react';

const ReadabilityIndicator = ({ score }) => {
    let color = "text-yellow-500";
    if (score >= 80) color = "text-green-500";
    if (score < 60) color = "text-red-500";

    return (
        <div className="flex items-center gap-2">
            <BarChart3 className={color} size={20} />
            <span className={`${color} font-medium`}>{score}% Readable</span>
        </div>
    );
};

const PublicationSummary = ({ publication }) => {
    const [isExpanded, setIsExpanded] = useState(false);

    // Default placeholder data
    const defaultData = {
        title: "Economic Impact of Digital Transformation",
        author: "Dr. Sarah Johnson",
        summary: "This paper examines the widespread effects of digital transformation on global economies, with particular focus on emerging markets and developed nations. The research indicates a strong correlation between digital adoption rates and GDP growth, while highlighting potential disparities in access to digital resources.",
        keywords: ["Digital Economy", "GDP Growth", "Market Analysis", "Innovation"],
        readabilityScore: 72,
        originalLength: 15200,
        summaryLength: 3800
    };

    const data = publication || defaultData;

    return (
        <Card className="w-full max-w-4xl mx-auto">
            <CardHeader className="border-b border-gray-200">
                <div className="flex justify-between items-start">
                    <div>
                        <h2 className="text-2xl font-bold text-gray-900">{data.title}</h2>
                        <p className="text-sm text-gray-500 mt-1">By {data.author}</p>
                    </div>
                    <ReadabilityIndicator score={data.readabilityScore} />
                </div>
            </CardHeader>

            <CardContent className="pt-6">
                {/* Summary Section */}
                <div className="space-y-4">
                    <div className="flex items-center gap-2 text-blue-600">
                        <BookOpen size={20} />
                        <h3 className="font-semibold">AI-Generated Summary</h3>
                    </div>
                    <p className="text-gray-700 leading-relaxed">
                        {isExpanded ? data.summary : `${data.summary.slice(0, 200)}...`}
                    </p>
                    {data.summary.length > 200 && (
                        <button
                            onClick={() => setIsExpanded(!isExpanded)}
                            className="text-blue-600 hover:text-blue-700 text-sm font-medium"
                        >
                            {isExpanded ? 'Show less' : 'Read more'}
                        </button>
                    )}
                </div>

                {/* Keywords Section */}
                <div className="mt-6">
                    <div className="flex items-center gap-2 text-blue-600 mb-3">
                        <Tag size={20} />
                        <h3 className="font-semibold">Key Concepts</h3>
                    </div>
                    <div className="flex flex-wrap gap-2">
                        {data.keywords.map((keyword, index) => (
                            <span
                                key={index}
                                className="px-3 py-1 rounded-full bg-blue-50 text-blue-700 text-sm"
                            >
                {keyword}
              </span>
                        ))}
                    </div>
                </div>

                {/* Statistics */}
                <div className="mt-6 pt-6 border-t border-gray-200">
                    <div className="grid grid-cols-2 gap-4 text-sm text-gray-500">
                        <div>
                            Original Length: {data.originalLength.toLocaleString()} words
                        </div>
                        <div>
                            Summary Length: {data.summaryLength.toLocaleString()} words
                        </div>
                    </div>
                </div>
            </CardContent>
        </Card>
    );
};

export default PublicationSummary;