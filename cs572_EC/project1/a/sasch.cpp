vf sasch(vf point) {
    vf currentPoint = point; // the zero-magnitude vector is common

    float before = getsch(currentPoint); // previous fitness
    float temp, delta, temp2;                          // current fitness
    float prob, pp;

    vector<int> midx; // mutation index
    vf newPoint;     // records best point
    int j;
    float accelerate = 2.5;
    float r = 0.99995;

    for (int T = 100; T > 0;) {
	before = getsch(currentPoint);
	j = 0;
	// decide which ones to mutate
	for (int i = 0; i < 15; ++i) 
	    midx.push_back( rand() % 30 );
	sort(midx.begin(), midx.end());

	for (int i = 0; i < 30; ++i) {
	    if (i != midx[j])    // not mutated
		newPoint.push_back(currentPoint[i]);
	    else {   // need to mutate this point
		delta = ( rand() % 10000 ) / 10000;
		while (currentPoint[i]-delta < schl || currentPoint[i]+delta > schh) {
		    delta = ( rand() % 10000 ) / 10000;
		    if (genRan() < 0.5)   // pos
			temp2 = currentPoint[i] + delta;
		    else                  // neg
			temp2 = currentPoint[i] - delta;
		} // while
		++j;
		newPoint.push_back(temp2);
	    } // else
	} // for

	temp = getsch(newPoint);
	if(temp < before) 
	    currentPoint = newPoint;
	else {
	    prob = getprob(before, temp, T, accelerate);
	    pp = genRan();
	    if (prob > pp)   // accept change
		currentPoint = newPoint;
	    for (int i = 0; i < 15; ++i) {
		midx.pop_back();
		newPoint.pop_back();
		newPoint.pop_back();
	    } // for
	} // else
	T = r*T;
    }
    return currentPoint;
} 

