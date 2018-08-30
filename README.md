# docker-opennlp

A Docker image for [OpenNLP](https://opennlp.apache.org/).

## How to use this image

### Build

```sh
docker build -t opennlp-docker .
```

### Run

#### Sentence detection

Given an a file called `input.txt` with the following text:

```
This is the first sentence. This is the second sentence. And the third.
Also the fourth sentence. And the fifth sentence.
```

Run the following to segment the sentences (from the same directory as `input.txt`):

```sh
docker run --rm -i -v $PWD:/usr/src/myapp opennlp-docker SentenceDetector /models/en-sent.bin < input.txt
```

This will produce the following output:

```
Loading Sentence Detector model ... done (0.061s)
This is the first sentence.
This is the second sentence.
And the third.
Also the fourth sentence.
And the fifth sentence.



Average: 833.3 sent/s 
Total: 5 sent
Runtime: 0.006s
Execution time: 0.078 seconds
```

If you'd like to get the split sentences in a separate file, redirect the output:

```sh
docker run --rm -i -v $PWD:/usr/src/myapp opennlp-docker SentenceDetector /models/en-sent.bin < input.txt > output.txt
```

The following models are included in the image (in the `/models` directory):

- en-sent.bin
- en-ner-person.bin
- en-ner-organization.bin

To use any other model, you'll need to either [download](http://opennlp.sourceforge.net/models-1.5/) it or train it and load it in yourself.

To better understand OpenNLP, see their [documentation](https://opennlp.apache.org/docs/1.9.0/manual/opennlp.html).