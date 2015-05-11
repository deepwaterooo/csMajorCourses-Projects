vf sasch(vf point) {
    vf currentPoint;
    bestScore = INF;
    float stepSize[30] = { 1.1, 1.1, 1.1, 1.1, 1.1,  1.1, 1.1, 1.1, 1.1, 1.1,
			   1.1, 1.1, 1.1, 1.1, 1.1,  1.1, 1.1, 1.1, 1.1, 1.1, 
			   1.1, 1.1, 1.1, 1.1, 1.1,  1.1, 1.1, 1.1, 1.1, 1.1 };    
    float acceleration = 32.5;
    currentPoint = point;
    float before;
    int besti, bestj, curri, currj;
    float candidate[5], miny = INF;
    int minidx;
    vf sschange, ssfive, vfive, vy;
    vvf once, five;
    int factor = 10;
    float temp, delta;
    float prob, pp, prob1, prob2;
    float r = 0.99995;
    for (int i = 0; i < 30; ++i)
	sschange.push_back(0);

    for (float t = 100; t > 0;) {
	/*
	candidate[0] = -acceleration;
	candidate[1] = -0.5 * acceleration;
	candidate[2] = 0;
	candidate[3] = 0.5 * acceleration;
	candidate[4] = acceleration;
	*/
	candidate[0] = -genRan();
	candidate[1] = -2.5 * genRan();
	candidate[2] = 0;
	candidate[3] = 2.5 * genRan();
	candidate[4] = genRan();
	besti = -1;
	curri = -1;
	before = getsch(currentPoint); 

	for (int i = 0; i < 30; ++i){    
	    bestj = -1;
	    for (int j = 0; j < 5; ++j) {  // try each of 5 candidate locations
		currj = -1;
		currentPoint[i] = currentPoint[i] + stepSize[i]*candidate[j];
		if (currentPoint[i] < schl || currentPoint[i] > schh) {
		    for (int a = 0; a < 30; ++a)
			vfive.push_back(0);  // vector<float>(30)
		    five.push_back(vfive);   // V 5 of ^
		    continue;
		}
		temp = getsch(currentPoint);
		if (temp < before) {
		    before = temp;
		    currj = j;
		}
		five.push_back(currentPoint);
		currentPoint[i] = currentPoint[i] - stepSize[i]*candidate[j];  // recover back
	    } // j
	    if ( (currj != -1) && (candidate[currj] != 0) ) {
		currentPoint = five[currj];
		sschange[i] = stepSize[i] * candidate[currj];   // record the ith change
		curri = i;
	    } 
	    if (bestj != -1) {
		besti = i;
	    }
	    once.push_back(currentPoint);
	    vy.push_back(getsch(currentPoint));
	    currentPoint = point;
	    for (int a = 0; a < 5; ++a) 
		five.pop_back();  // empty V five
	} // i
	if (curri != -1) {
	    currentPoint = once[curri];
	    stepSize[curri] = sschange[curri];
	} else {  // accept the best one with probability 
	    int x = vminidx(vy);
	    prob1 = getprob(before, vy[x], t, acceleration);  // prob < (0, 1)
	    prob2 = getprob(vy[x], before, t, acceleration);    // modified 
	    pp = genRan();
	    prob = (prob1 > prob2 ? prob2 : prob1);
	    if (prob/1000000 > pp) { // accept one with probability
		currentPoint[x] = currentPoint[x] + sschange[x];
		before = vy[x];
	    }
	}
	printf("y: %5.4f\n", getsch(currentPoint));
	for (int i = 0; i < 30; ++i) {
	    sschange[i] = 0;
	    once.pop_back();
	    vy.pop_back();
	}
	t = r * t;
    }  // x
    return currentPoint;
}
