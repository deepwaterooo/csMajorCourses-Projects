vf sasch(vf point) {
    vf currentPoint;
    bestScore = INF;
    int factor = 10;

    float temp, delta;
    float prob, pp;
    float accelerate = 51.5000005;
    float r = 0.85;
    bool neg = false;

    currentPoint = point;
    float before = getsch(currentPoint);

    for (int t = 100; t > 0;) {
	int xi = rand() % 30;
	delta = rand() % factor % factor;

	if (genRan() < 0.500000) {
	    neg = false;
	    currentPoint[xi] = currentPoint[xi] + delta;
	} else {
	    neg = true;
	    currentPoint[xi] = currentPoint[xi] - delta;
	}

	while (currentPoint[xi] < schl || currentPoint[xi] > schh) {
	    delta = rand() % factor % factor; 

	    if (genRan() < 0.500000) {
		neg = false;
		currentPoint[xi] = currentPoint[xi] + delta;
	    } else {
		neg = true;
		currentPoint[xi] = currentPoint[xi] - delta;
	    }
	}
	temp = getsch(currentPoint);

	if (temp < bestScore) {// accept currentPoint
	    bestScore = temp;
	    before = temp;
	} else {
	    prob = getprob(before, temp, t, accelerate);  // prob < (0, 1)
	    pp = genRan();
	    if (prob <= pp) {  // reject change
		if (neg) {
		    currentPoint[xi] = currentPoint[xi] + delta;
		    neg = false;
		} else
		    currentPoint[xi] = currentPoint[xi] - delta; 
	    } else // accept change
		before = temp;
	}
	temp = INF;
	t = r * t;
    }
    return currentPoint;
}
